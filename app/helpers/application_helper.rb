module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-error',
    alert: 'alert-block',
    notice: 'alert-info'
  }

  def system_admin_side?
    controller.class.to_s.include?("SystemAdmin::")
  end

  def organization_admin_side?
    controller.class.to_s.include?("OrganizationAdmin::")
  end

  def active_link_to(title, link_path)
    path = request.path == "/" && title == "Home" ? "/" : link_path
    class_name = request.path.include?(path) ? "active" : ""
    content_tag "li", class: class_name do
      link_to title, link_path
    end
  end

  def urls_to_images(s)
        s.gsub! /\s(http:\/\/.*?\.(png|jpg))\s/ ,
                    '<p><img src="\1"/></p>'
        s.html_safe
  end

  def urls_to_links(s)
        s.gsub! /\s(http:\/.*?)\s/ ,
                    '<a href="\1">\1'
        s.html_safe
  end

end
