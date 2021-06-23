class TimeTagSerializer < BaseSerializer
    def serialize_single(resource, _)

        duration_hours = Time.at( resource.duration ).utc.strftime("%H")
        duration_minutes = Time.at( resource.duration ).utc.strftime("%M")
        {
            id: resource.id,
            name: resource.name,
            duration: "#{duration_hours}hrs #{duration_minutes}mins" ,
            start_at: resource.start_at,
            end_at: resource.end_at
        }
    end

end