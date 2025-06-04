import "@typespec/http";
import "@typespec/rest";

using Http;
using Rest;

@service(#{ title: "skill category curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace SkillCategoryApi {
    model SkillCategory {
      @key id: int32;
      parent_id: int32;
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

    model ValidateError {
        message: string;
        errors: Record<string[]>;
    }
    model ValidationErrorResponse {
        ...Response<422>;
        ...Body<ValidateError>;
    }

    @doc("Trường hợp người dung không phải là bod, or HR")
    model PermissionErrorResponse {
        ...Response<403>;
        ...Body<{ message: "Forbidden" }>;
    }

    @route("/skills/categories")
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
        create(@body input: CreateSkillCategoryInput): SkillCategory | ValidationErrorResponse | PermissionErrorResponse;

        @get()
        show(@path skillCategoryId: int32): SkillCategory | NotFoundResponse;

        @put()
        update(@path skillCategoryId: int32, @body input: CreateSkillCategoryInput): SkillCategory | ValidationErrorResponse | PermissionErrorResponse;

        @delete()
        delete(@path skillCategoryId: int32): void | NotFoundResponse | PermissionErrorResponse;
    }
}