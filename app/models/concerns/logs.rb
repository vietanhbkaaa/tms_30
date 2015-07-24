module Logs
  def create_activity action, user_id, target_id, content
    Activity.create!( type_action: action, user_id: user_id,
      target_id: target_id, content: content)
  end
end
