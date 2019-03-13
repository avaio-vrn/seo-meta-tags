# -*- encoding : utf-8 -*-
class Seo::MetaTag < ActiveRecord::Base
  before_save :controller_action_id

  attr_accessible :tag, :content_name, :content_value, :key_name, :key_value, :cnt, :ac, :id_obj, :mode
  attr_accessor :cnt, :ac, :mode

  validate :uniqueness_tag

  def mode
    self.class.get_mode key_name.to_sym
  end

  def json_for_icons_js(ability_destroy, index=nil)
    index ||= :_no_index
    json = { index =>
             { record:
               { action_path: "/seo/meta_tags/" + self.id.to_s,
                model: "Seo::MetaTag",
                namespace: 'seo',
                model_module: "meta_tag_engine",
                can_destroy: ability_destroy,
                id: id }}
    }
    json
  end

  private

  def uniqueness_tag
    rel = Seo::MetaTag.where(controller: cnt, action: ac, id_obj: id_obj, tag: tag, content_name: content_name, key_name: key_name)
    rel = rel.where("id <> ?", id) if id
    errors.add :content_name, "Запись уже существует" unless rel.blank?
  end

  def controller_action_id
    self.controller = cnt
    self.action = ac
  end

  def self.get_mode(type)
    case type
    when :title;        1
    when :keywords;     2
    when :description;  3
    else;               4
    end
  end

  def self.get_type(mode)
    case mode
    when 1; :title
    when 2; :keywords
    when 3; :description
    else; mode
    end
  end

end
