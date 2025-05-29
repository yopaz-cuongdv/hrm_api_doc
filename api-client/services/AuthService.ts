/* generated using openapi-typescript-codegen -- do not edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { AuthApi_AuthToken } from '../models/AuthApi_AuthToken';
import type { AuthApi_LoginInput } from '../models/AuthApi_LoginInput';
import type { AuthApi_RegisterInput } from '../models/AuthApi_RegisterInput';
import type { CancelablePromise } from '../core/CancelablePromise';
import { OpenAPI } from '../core/OpenAPI';
import { request as __request } from '../core/request';
export class AuthService {
    /**
     * @param requestBody
     * @returns AuthApi_AuthToken The request has succeeded.
     * @throws ApiError
     */
    public static authLoginLogin(
        requestBody: AuthApi_LoginInput,
    ): CancelablePromise<AuthApi_AuthToken> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/auth/login',
            body: requestBody,
            mediaType: 'application/json',
        });
    }
    /**
     * @param requestBody
     * @returns AuthApi_AuthToken The request has succeeded.
     * @throws ApiError
     */
    public static authRegisterRegister(
        requestBody: AuthApi_RegisterInput,
    ): CancelablePromise<AuthApi_AuthToken> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/auth/register',
            body: requestBody,
            mediaType: 'application/json',
        });
    }
}
