module RemoteLinkPaginationHelper
  class LinkRenderer < WillPaginate::ActionView::BootstrapLinkRenderer
    def link(text, target, attributes = {})
      attributes['data-remote'] = true
      super
    end
  end
end
