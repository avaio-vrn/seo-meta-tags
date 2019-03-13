# -*- encoding : utf-8 -*-
class Seo::MetaTagsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_actions, if: proc { current_user&.admin_less? }

  def index
    @metas = SEO::MetaTagsOnPage.new(params[:cnt], params[:ac], params[:id_obj])
    @metas_list = [@metas.title, @metas.keywords, @metas.description]
  end

  def edit
    params.merge! params[:sending_data]
  end

  def show
    params.merge! params[:sending_data]
  end

  def new
    @meta_tag = Seo::MetaTag.new(params[:seo_meta_tag].merge(content_value: I18n.t(:edit, scope: :template_system_content_text) ))

    respond_to do |format|
      if @meta_tag.save
        params.merge! params[:seo_meta_tag]
        format.js { render 'create', layout: nil}
      else
        format.js { render text: 'alert(Ошибка добавления записи. Сообщите разработчикам!);', layout: nil }
      end
    end
  end

  def update
    respond_to do |format|
      params[:values].map(&:strip!)
      if @meta_tag.update_attributes(params[:sending_data].merge(content_value: params[:values][0]))
        params.merge! params[:sending_data]
        format.js { render 'show' }
      else
        format.js { render text: 'alert("Ошибка! Не удалось сохранить данные! Сообщите разработчикам!")' }
      end
    end
  end

  def destroy
    params.merge! cnt: @meta_tag.controller, ac: @meta_tag.action, id_obj: @meta_tag.id_obj
    @meta_tag.destroy

    respond_to do |format|
      format.json { render json: @meta_tag.to_json }
      format.js { render 'destroy', layout: nil }
    end
  end

  private

  def set_actions
    @admin_panel = Admin::Panel::Base.new(::Seo::MetaTag, { namespace: 'seo' })
    @admin_panel.from(controller_name, action_name)
    @admin_panel.model_engine = 'seo'
    @admin_panel.routes_set
    @admin_panel.routes.delete_if { |a| a == :show || a == :edit }
    @title_params = { cnt: params[:cnt], ac: params[:ac], id_obj: params[:id_obj], key_name: 'title' }
    @description_params = { cnt: params[:cnt], ac: params[:ac], id_obj: params[:id_obj], key_name: 'description' }
  end
end
