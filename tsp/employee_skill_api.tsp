import "@typespec/http";
import "@typespec/rest";

using Http;

@service(#{ title: "Employee Skill Service" })
@server("http://localhost:8080", "LocalServer")
namespace SkillApi {

  // ======== Skill ========
  model Skill {
    @key
    id: int32;
    name: string;
    description?: string;
  }

  model CreateSkillInput {
    name: string;
    description?: string;
  }

  model UpdateSkillInput {
    name?: string;
    description?: string;
  }

  // ======== Employee Skill ========
  model EmployeeSkill {
    @key
    id: int32;
    employee_id: int32;
    skill_id: int32;
    level: string; // beginner | intermediate | expert
    years_experience: float32;
    created_by: string;
    updated_by: string;
  }

  model CreateEmployeeSkillInput {
    employee_id: int32;
    skill_id: int32;
    level: string;
    years_experience: float32;
    created_by: string;
  }

  model UpdateEmployeeSkillInput {
    level?: string;
    years_experience?: float32;
    updated_by: string;
  }

  // ======== API: Skill CRUD ========
  @tag("Skills")
  interface skill {
    @route("/skills")
    @get
    list(): Skill[];

    @route("/skills")
    @post
    create(@body input: CreateSkillInput): Skill;

    @route("/skills/{id}")
    @get
    show(@path id: int32): Skill;

    @route("/skills/{id}")
    @put
    update(@path id: int32, @body input: UpdateSkillInput): Skill;

    @route("/skills/{id}")
    @delete
    delete(@path id: int32): void;
  }

  // ======== API: Employee Skill CRUD ========
  @tag("EmployeeSkills")
  interface employeeSkill {
    @route("/employee-skills")
    @get
    list(): EmployeeSkill[];

    @route("/employee-skills")
    @post
    create(@body input: CreateEmployeeSkillInput): EmployeeSkill;

    @route("/employee-skills/{id}")
    @get
    show(@path id: int32): EmployeeSkill;

    @route("/employee-skills/{id}")
    @put
    update(@path id: int32, @body input: UpdateEmployeeSkillInput): EmployeeSkill;

    @route("/employee-skills/{id}")
    @delete
    delete(@path id: int32): void;
  }
}
