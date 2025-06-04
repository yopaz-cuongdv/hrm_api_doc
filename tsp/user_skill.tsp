import "@typespec/http";
import "@typespec/rest";


using Http;
using Rest;

@service(#{ title: "user skill curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace UserSkillApi {
    model UserSkill {
      id: int32;
      @key
      skill_id: int32;
      user_id: int32;
      level: string;
      years_experience: float32;
    }

    model CreateUserSkillInput {
      user_id: int32;
      skill_id: int32;
      level: string;
      years_experience: float32;
    }

    model UpdateUserSkillInput {
      level: string;
      years_experience: float32;
    }

    model UserSkillPagination {
      data: UserSkill[];
      page: int32;
      pageSize: int32;
      totalPages: int32;
    }

    @route("/skills")
    @tag("Skills")
    @useAuth(BearerAuth)

    interface userSkill {
        @get()
          list(
            @query search?: string,
            @query sort_by?: string,
            @query sort_order?: "asc" | "desc",
            @query per_page?: int32,
          ): UserSkillPagination[];
        @post()
        create(@body input: CreateUserSkillInput): UserSkill;

        @get()
        show(@path userSkillId: int32): UserSkill;

      @put()
      update(@path userSkillId: int32, @body input: UpdateUserSkillInput): UserSkill;

      @delete()
      delete(@path userSkillId: int32): void;
    }
}