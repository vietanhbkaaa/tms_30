require "active_support/time"


every "59 23 28-31 * * [ &quot;$(date +%d -d tomorrow)&quot; = &quot;01&quot; ] &amp;&amp" do
  runner "User.monthly_report"
end

every :day, at: "6:00am" do
  runner "Course.notify_will_be_expired"
end

every :day, at: "11:00pm" do
  runner "User.send_trainees_report"
end
