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

  def get_url(host, page)
    return "#{host}/#{page.id}"
  end

  def get_short_title(title)
    return if title.blank?
    st = Pinyin.t(title).gsub(/(-|\s+)/, '-').gsub(/[^\w-]/, '')
    st = st.to_s.squeeze('-')[0..10].gsub(/\W+$/, '')
    while Page.where(short_title: st).any?
      st += ('a'..'z').to_a[rand(26)]
    end
    return st
  end

  #Tag 用以下的符号隔开都可以，就是不能用空格
  def update_tag(page)
    #remove all previows
    page.tag_list.clear
    #add new 
    page.keywords.split(SPECIAL_SYMBO_REG).each do |tag|
      next if SPECIAL_SYMBO_REG.match tag
      page.tag_list.add(tag)
      page.save!
    end
    puts "..................."
    return true
  end

end
