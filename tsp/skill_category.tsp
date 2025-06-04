import "@typespec/http";
import "@typespec/rest";

using Http;
using Rest;

@service(#{ title: "skill category curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace SkillCategoryApi {
    model SkillCategory {
      id: int32;
      @key
      key: string;
      name: string;
      type: string;
      description: string;
    }

    model CreateSkillCategoryInput {
      key: string;
      name: string;
      type: string;
      description?: string;
    }

    model SkillCategoryPagination {
      data: SkillCategory[];
      page: int32;
      pageSize: int32;
      totalPages: int32;
    }

    @route("/skill-sheet/skill-categories")
    @tag("Skill Categories")
    @useAuth(BearerAuth)

    interface skillCategory {
        @get()
          list( 
            @query search?: string,
            @query sort_by?: string,
            @query sort_order?: "asc" | "desc",
            @query per_page?: int32,
            ): SkillCategoryPagination[];
        @post()
        create(@body input: CreateSkillCategoryInput): SkillCategory;

        @get()
        show(@path skillCategoryId: int32): SkillCategory;

      @put()
      update(@path skillCategoryId: int32, @body input: CreateSkillCategoryInput): SkillCategory;

      @delete()
      delete(@path skillCategoryId: int32): void;
    }
}