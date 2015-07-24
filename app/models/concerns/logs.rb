module Logs
  def log_create
    Activity.create!( type_action: Settings.logs.create, user_id: :admin, target_id: self.id)
  end

  def log_update
    Activity.create!( type_action: Settings.logs.update, user_id: self.id, target_id: self.id)
  end

  def log_destroy
    Activity.create!( type_action: Settings.logs.delete, user_id: :admin, target_id: self.id)
  end
end
