import "@typespec/http";
import "@typespec/rest";


using Http;
using Rest;

@service(#{ title: "user skill curd service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace UserSkillApi {
    model UserSkill {
      @key id: int32;
      skill_id: int32;
      user_id: int32;
      level: float32;
      years_experience: float32;
    }

    model CreateUserSkillInput {
      skill_id: int32;
      level: float32;
      years_experience: float32;
    }

    model UpdateUserSkillInput {
      skill_id: int32;
      level: float32;
      years_experience: float32;
    }

    model UserSkillPagination {
      data: UserSkill[];
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

    model PermissionErrorResponse {
        ...Response<403>;
        ...Body<{ message: "Forbidden" }>;
    }

    @route("/user/{userId}/skills")
    @tag("User Skills")
    @useAuth(BearerAuth)

    interface userSkill {
        @get()
          list(
            @path userId: int32,
            @query search?: string,
            @query sort_by?: string,
            @query sort_order?: "asc" | "desc",
            @query per_page?: int32,
          ): UserSkillPagination[] | NotFoundResponse;

        @post()
        create(@path userId: int32, @body input: CreateUserSkillInput): UserSkill | ValidationErrorResponse | PermissionErrorResponse;
        
        @get()
        show(@path userId: int32, @path userSkillId: int32): UserSkill | NotFoundResponse;

        @put()
        update( @path userId: int32, @path userSkillId: int32, @body input: UpdateUserSkillInput): UserSkill | ValidationErrorResponse | PermissionErrorResponse;

        @delete()
        delete(@path userId: int32, @path userSkillId: int32): void | NotFoundResponse;
    }
}