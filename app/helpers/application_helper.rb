module ApplicationHelper
  def shallow_resource(*args)
    if args.last.persisted?
      args.last
    else
      args
    end
  end

  def render_flash
    javascript_tag('App.flash = JSON.parse(' "'#{j({ success: flash.notice, error: flash.alert }.to_json)}'" ');')
  end

  def nav_link(text, path)
    options = current_page?(path) ? { class: 'active' } : {}
    content_tag(:li, options) do
      link_to text, path
    end
  end

  def app_name
    Rails.application.class.parent_name.underscore.humanize.split.map(&:capitalize).join(' ')
  end

  def full_title(page_title)
    base_title = app_name
    if page_title.empty?
      base_title
    else
      "#{base_title} #{page_title}"
    end
  end
end
