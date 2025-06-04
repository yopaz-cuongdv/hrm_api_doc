import "@typespec/http";
import "@typespec/rest";


using Http;
using Rest;

@service(#{ title: "skill curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace SkillApi {
    model Skill {
      id: int32;
      @key
      skill_category_id: int32;
      name: string;
    }

    model CreateSkillInput {
      skill_category_id: int32;
      name: string;
    }

    model SkillPagination {
      data: Skill[];
      page: int32;
      pageSize: int32;
      totalPages: int32;
    }

    @route("/skill-sheet/skills")
    @tag("Skills")
    @useAuth(BearerAuth)

    interface skill {
        @get()
          list(
            @query search?: string,
            @query sort_by?: string,
            @query sort_order?: "asc" | "desc",
            @query per_page?: int32,
          ): SkillPagination[];
        @post()
        create(@body input: CreateSkillInput): Skill;

        @get()
        show(@path skillId: int32): Skill;

      @put()
      update(@path skillId: int32, @body input: CreateSkillInput): Skill;

      @delete()
      delete(@path skillId: int32): void;
    }
}