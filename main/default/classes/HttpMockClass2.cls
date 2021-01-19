@isTest
global class HttpMockClass2 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Authorization','Bearer '+'ya29.a0AfH6SMAKXUlo_Lg5fgnGq3Es1KUiT_vcktQc2HZ5p5QOEaNFhhK0t07X1wdPka7A5OrqHrU7wbuvN8vK2oV9-8dLJ-Q8MK4c0mP14R8cJrd4LvCnTWAqi5Cl4vP2NaBEiI_cFDvpPOnh_gMcrwi3XDwCtfuR8VgSKSk');
        res.setBody('{"resourceName": "people/118322888014870630050","etag": "%EgUBCT43LhoEAQIFByIMU2F5bVlSMUg4RjA9","emailAddresses": [{"metadata": {"primary": true, "verified": true,"source": {"type": "DOMAIN_PROFILE", "id": "118322888014870630050"}},"value": "mubasher.khazir@cloudanalogy.com"}]}');

        res.setStatusCode(200);
        return res;
    }
}