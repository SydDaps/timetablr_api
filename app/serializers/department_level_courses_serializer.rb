class DepartmentLevelCoursesSerializer < BaseSerializer
    def serialize_single(resource, _)
        {   
            department_id: resource.id,
            name: resource.name,
            code: resource.code,
            levels: LevelSerializer.new( resource.time_table.levels.all ).serialize.map{
                |l| l.merge(
                    courses: CourseSerializer.new( Level.find(l[:level_id]).courses.where(department_id: resource.id ) ).serialize
                ) 
            }
        }
    end
end