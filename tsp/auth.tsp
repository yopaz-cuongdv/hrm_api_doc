import "@typespec/http";

using Http;


@service(#{ title: "Auth API Service" })
@server("http://id.yopaz.test/api", "LocalServer")

namespace AuthApi {

   // # Auth
   model RegisterInput {
     name: string;
     email: string;
     password: string;
   }

   model LoginInput {
     email: string;
     password: string;
   }

   model AuthToken {
     access_token: string;
   }

   @tag("Auth")
    interface auth {
        @route("/register")
       @post()
        register(@body input: RegisterInput): AuthToken;

        @route("/login")
        @post()
        login(@body input: LoginInput): AuthToken;

   }

}