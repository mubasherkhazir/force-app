public with sharing class Youtubesearch {

    
    public static final string key = '1C1CHBF_enIN887IN887';


    @AuraEnabled(cacheable=true)
    public static String search(String searchstr){
        // Instantiate a new http object
        Http h = new Http();
         // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        String searche =EncodingUtil.urlencode(searchstr,'UTF-8');
        string url = 'https://www.google.com/search?q='+searche+'gth&rlz='+key;
        //String url = youtubesearchURL;
        req.setEndpoint(url);
        req.setMethod('GET');
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        system.debug('RESULTS..>>>'+res.getBody());
        return res.getBody();
        //system.debug('RESULTS..>>>'+YoutubeDataParser.parse(res.getBody()));
        //return YoutubeDataParser.parse(res.getBody());
    }

}