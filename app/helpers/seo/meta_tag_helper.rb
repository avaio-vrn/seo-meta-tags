module Seo::MetaTagHelper
  def meta_tags_html
    meta = "\t".html_safe
    meta << tag(:meta, name: :description, content: @metas.description_tag) unless @metas.description_tag.blank?
    @metas.meta_tags_plus.map do |meta_tags_plus|
      meta << if meta_tags_plus.content_name.blank?
               tag(meta_tags_plus.tag, meta_tags_plus.key_name => meta_tags_plus.key_value)
      else
        tag(meta_tags_plus.tag, meta_tags_plus.key_name => meta_tags_plus.key_valuem, meta_tags_plus.content_name => meta_tags_plus.content_value)
      end
    end
    meta
  end

  def title
    params = request.params
    @metas = SEO::MetaTagsOnPage.new(params[:controller].gsub('/', '_'), params[:action], params[:id])
    @title_tag ||= @metas.title_tag
    if @title_tag.blank?
      if @title.nil?
        base_title
      else
        "#{@title} | #{base_title}"
      end
    else
      if base_title.blank?
        "#{@title_tag}"
      else
        "#{@title_tag} | #{base_title}"
      end
    end
  end

  private

  def base_title
    ::Configuration.loaded_get('main', 'base_title')
  end
end
