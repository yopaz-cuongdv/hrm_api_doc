import "@typespec/http";
import "@typespec/rest";


using Http;
using Rest;

@service(#{ title: "skill curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace SkillApi {
    model Skill {
      @key id: int32;
      skill_category_id: int32;
      key: string;
      name: string;
    }

    model CreateSkillInput {
      skill_category_id: int32;
      key: string;
      name: string;
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
    
    model SkillPagination {
      data: Skill[];
      page: int32;
      pageSize: int32;
      totalPages: int32;
    }

    @route("/skills")
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
        create(@body input: CreateSkillInput): Skill | ValidationErrorResponse | PermissionErrorResponse;

        @get()
        show(@path skillId: int32): Skill | NotFoundResponse; 
        
        @put()
        update(@path skillId: int32, @body input: CreateSkillInput): Skill | ValidationErrorResponse | PermissionErrorResponse;

        @delete()
        delete(@path skillId: int32): void | NotFoundResponse | PermissionErrorResponse;
    }
}