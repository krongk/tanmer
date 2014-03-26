module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  SPECIAL_SYMBO_REG = /(,|;|:|\.|\||\\|，|；|。|、)/

  def title(page_title)
    content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
    content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
    content_for(:meta_description){ meta_description}
  end
  def content(item_content)
    content_for(:content){ raw item_content }
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  #match '/p/u:user_id-p:id', to: "home#show", via: :get
  #pr_id : page_rate id 
  def get_url(page, pr_id = 0)
    return "#{ENV["HOST_NAME"]}/p/u#{page.user.id}-p#{page.short_title}#{pr_id == 0 ? '' : '?pr_id=' + pr_id.to_s}"
  end
end
