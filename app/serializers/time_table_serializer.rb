class TimeTableSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            kind: resource.kind,
            status: resource.status,
            Days: DaySerializer.new(resource.days).serialize
        }
    end

end