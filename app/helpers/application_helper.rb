module ApplicationHelper
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end
end
