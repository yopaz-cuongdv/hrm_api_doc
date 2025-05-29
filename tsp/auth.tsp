import "@typespec/http";

using Http;


@service(#{ title: "Auth API Service" })

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

   @route("/auth")
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