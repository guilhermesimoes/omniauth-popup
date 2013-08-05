module ApplicationHelper
  def link_to_login_with(provider, url, popup = {})
    link_to t('.login_with_link', provider: provider),
      url,
      class: 'js-popup',
      data: { width: popup[:width], height: popup[:height] }
  end
end
