module EventsHelper
   def destroy_attendances(event_id)
    @event = Event.find(id: event_id)

    #@attendances = Attendance.where(:event_id => event_id)
    #puts attendances

    end
end
