import "@typespec/http";
import "@typespec/rest";


using Http;
using Rest;

@service(#{ title: "User CRUD Service" })
@server("http://id.yopaz.test/api", "LocalServer")
// @server("http://test.me:8080", "TestServer")

namespace UserApi {
    model User {
      id: int32;
      @key
      name: string;
      email: string;
    }

    model CreateUserInput {
      name: string;
      email: string;
    }

    model Post {
      @key
      id: int32;
      title: string;
      content: string;
      userId: int32;
    }

    model PostPagination {
      data: Post[];
      page: int32;
      pageSize: int32;
      totalPages: int32;
    }

    // # User CRUD (requires token)
    @route("/user")
    @tag("Users")
    @useAuth(BearerAuth)

    interface user {
        @get()
          list(
            @query search?: string,
            @query sort_by?: string,
            @query sort_order?: "asc" | "desc",
            @query per_page?: int32,
            @query status?: string,
            @query role?: string
          ): User[];
        @post()
        create(@body input: CreateUserInput): User;

        @get()
        show(@path userId: int32): User;

      @put()
      update(@path userId: int32, @body input: CreateUserInput): User;

      @delete()
      delete(@path userId: int32): void;

    }
}