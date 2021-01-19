@isTest
global class HttpMockClass1 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        res.setBody('{"access_token": "ya29.a0AfH6SMAKXUlo_Lg5fgnGq3Es1KUiT_vcktQc2HZ5p5QOEaNFhhK0t07X1wdPka7A5OrqHrU7wbuvN8vK2oV9-8dLJ-Q8MK4c0mP14R8cJrd4LvCnTWAqi5Cl4vP2NaBEiI_cFDvpPOnh_gMcrwi3XDwCtfuR8VgSKSk","expires_in": 3599,"scope": "https://www.googleapis.com/auth/userinfo.profile openid https://www.googleapis.com/auth/profile.emails.read https://www.googleapis.com/auth/userinfo.email","token_type": "Bearer","id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0MWEzNTcwYjhlM2FlMWI3MmNhYWJjYWE3YjhkMmRiMjA2NWQ3YzEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNDY2NjA5Mzc5NzgwLWM0a2o3anY4OXRxMWRpdGJqbm9jbjJ2dHBtYnFqZnJ0LmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNDY2NjA5Mzc5NzgwLWM0a2o3anY4OXRxMWRpdGJqbm9jbjJ2dHBtYnFqZnJ0LmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE4MzIyODg4MDE0ODcwNjMwMDUwIiwiaGQiOiJjbG91ZGFuYWxvZ3kuY29tIiwiZW1haWwiOiJtdWJhc2hlci5raGF6aXJAY2xvdWRhbmFsb2d5LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVE5INTlpbFBYYTVIYUtYOXpmMTVxQSIsImlhdCI6MTU5Mzg1MzU2MCwiZXhwIjoxNTkzODU3MTYwfQ.Ngi9xCObZYwUz_Ufb2TzzKz4zP-CDf8SnCZuxYI31Mh1SnutiPqnERuA9K_P0aCGfFNwqhOPMY-k_oR61sHTymgkj4iS4Wv8kRStZtdPULXmKPylN5CZ-w6qpneyrE0ntc4--EuWkTkuaRqlTKP2mHzVSDeWUqp-lG6kVEo_GySyFByRrRIV6-nEcF7q0uqxkhID0Auq629QIx6-J75QNuuOwekopKeNO1lz-z_882vyxPzVldZTLoO7w7N-Z7OWKvrhmwWTKLZUC9aegBGXVlwgT2YGcfflCfJhzuNbgW94Ue0uGhOL-QCo0Mbj7t1-3ImwiexAp51EZDnauiKGqA"}');
        res.setStatusCode(200);
        Test.setMock(HttpCalloutMock.class, new HttpMockClass2());

        return res;
    }
}