module TasksHelper
  def done_time_tag(task)
    return '' if !task.done?

    content_tag(
      :span,
      task.done_at.strftime("%l:%M %P on %b %e, %Y"),
      class: 'time'
    )
  end
end
