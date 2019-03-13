class SEO::MetaTagsOnPage
  def initialize(controller, action, obj)
    @meta_tags_plus = if obj.blank?
                        Seo::MetaTag.where("controller = ? AND action = ?", controller, action).all
                      else
                        Seo::MetaTag.where("controller = ? AND action = ? AND id_obj = ?", controller, action, obj).all
                      end
    @title_tag = []
    @keywords_tag = []
    @description_tag = []

    @meta_tags_plus.delete_if do |a|
      case a.key_name.to_sym
      when :title
        @title_tag << a
      when :keywords
        @keywords_tag << a
      when :description
        @description_tag << a
      end
    end
  end

  def title
    @title_tag.first
  end

  def keywords
    @keywords_tag.first
  end

  def description
    @description_tag.first
  end

  def title_tag
    @title_tag.blank? ? "" : @title_tag.first.content_value
  end

  def keywords_tag
    @keywords_tag.blank? ? "" : @keywords_tag.first.content_value
  end

  def description_tag
    @description_tag.blank? ? "" : @description_tag.first.content_value
  end

  def meta_tags_plus
    @meta_tags_plus
  end
end
