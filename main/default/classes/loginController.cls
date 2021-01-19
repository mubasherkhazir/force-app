public class loginController
{
    public string errMsg{get;set;}
    public static final string REDIRECT_URL='https://mubashir-dev-ed--c.visualforce.com/apex/GoogleLogin';
    
    
    
    // main method used for api calling and redirection after matching email with contact email
    
    public PageReference googleSignIn()
    {
        
        try
        {
            String code = ApexPages.currentPage().getParameters().get('code');
            system.debug('value of code is @@@@@'+code);
            if(String.isNotBlank(code))
            {
                
                // getting all the values from custom labels
                
                String clientId = '466609379780-c4kj7jv89tq1ditbjnocn2vtpmbqjfrt.apps.googleusercontent.com';
                String clientSecret = 'qUjrdZbAfYH5FkMFOFwGE1AM';
                //String redirectURI = 'https://www.google.com';
                
                // request for access token
                
                HttpRequest req = new HttpRequest();
                String body='code='+code+'&client_id='+clientId+'&client_secret='+clientSecret+'&redirect_uri='+REDIRECT_URL+'&grant_type=authorization_code';
                System.debug('body'+body);
                req.setEndpoint('https://accounts.google.com/o/oauth2/token');
                req.setMethod('POST');
                req.setHeader('Content-Type','application/x-www-form-urlencoded');
                req.setBody(body);
                Http http = new Http();
                HttpResponse res = http.send(req);
                String response = res.getBody();
                system.debug('value of response is @@@@@'+response);
                if(res.getStatusCode() == 200)
                {
                    
                    Map<String,Object> accessTokenMap = (Map<String,Object>)JSON.deserializeUntyped(response);
                    system.debug('value of accessTokenMap is @@@@@'+accessTokenMap);
                    
                    String accTok = String.valueOf(accessTokenMap.get('access_token'));
                    system.debug('value of accTok'+accTok);
                    
                    // After getting access token we send second request to google people api to get user email  by sending access token in request
                    
                    if(String.isNotBlank(accTok))
                    {
                        HttpRequest req1 = new HttpRequest();
                        req1.setEndpoint('https://people.googleapis.com/v1/people/me?personFields=emailAddresses');
                        req1.setMethod('GET');
                        req1.setHeader('Authorization','Bearer '+accTok);
                        Http http1 = new Http();
                        HttpResponse res1 = http1.send(req1);
                        
                        String emailResponse = res1.getBody();
                        System.debug('emailResponse '+emailResponse);
                        if(String.isNotBlank(emailResponse))
                        {
                            Map<String,Object> emailMap = (Map<string,object>)JSON.deserializeUntyped(emailResponse);
                            List<Object> emailValueList = (List<Object>)emailMap.get('emailAddresses');
                            String emailJSON = JSON.serialize(emailValueList);
                            system.debug('email user 1 '+emailJSON);
                            
                            emailJSON = emailJSON.removeStart('[').removeEnd(']');
                            // deserialize into apex wrapper
                            
                            googleEmailWrapper gewList = (googleEmailWrapper)JSON.deserialize(emailJSON,googleEmailWrapper.class);
                            System.debug('gewList.value'+gewList.value);
                            
                            if(gewList != null)
                            {
                                String email = gewList.value;
                                if(String.isNotBlank(email))
                                {
                                    
                                    // getting all the contacts
                                    
                                    List<Contact> stuEmails = [SELECT Id,Email FROM Contact LIMIT 50000];
                                    if(stuEmails != null && stuEmails.size() > 0)
                                    {
                                        boolean isMatch = false;
                                        
                                        // checking either there is any contact match with response email id
                                        
                                        for(Contact ss: stuEmails)
                                        {
                                            
                                            // If email id matched then store data in cookies and redirect user to success page
                                            
                                            if(ss.Email == email)
                                            {
                                                Cookie coo = new Cookie('con',ss.Id,null,-1,false);
                                                PageReference ref = new PageReference('/apex/LearningSlds');
                                                ref.setCookies(new Cookie[]{coo});
                                                ref.setRedirect(true);
                                                isMatch = true;
                                                return ref;
                                            }
                                        }
                                        if(!isMatch)
                                        {
                                            errMsg = 'ERROR: Email ID not found in our system, please use your registered email to sign in.';
                                            return null;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    errMsg = 'ERROR: Session expired, please login again.';
                    return null;
                }
                return null;
                
            }
            
            else
            {
                errMsg ='';
                return null;
            }
        }
        catch(Exception e)
        {
            errMsg = 'ERROR: '+e.getMessage()+' – '+e.getLineNumber();
            return null;
        }
    }
    
    // this method is only used for simple logged in
    
    @RemoteAction
    public static String login(String username, String password)
    {
        try
        {
            List<Contact> stuList = [SELECT Id,Username__c,Password__c
                                     FROM Contact
                                     WHERE Username__c != null AND Username__c != ''
                                     LIMIT 50000];
            
            Map<String,Contact> stuMap = new Map<String,Contact>();
            
            if(stulist != null && stulist.size() > 0)
            {
                For(Contact stu: stulist)
                {
                    If(String.isNotBlank(stu.Username__c))
                    {
                        stuMap.put(stu.Username__c,stu);
                    }
                }
                if(stuMap.containsKey(username))
                {
                    Contact stu = stuMap.get(username);
                    if(stu != null && String.isNotBlank(stu.Password__c))
                    {
                        if(stu.Password__c != password)
                        {
                            return 'Password does not match.';
                        }
                        else
                        {
                            return 'Success-'+stu.Id;
                        }
                    }
                    else
                    {
                        return 'Your account has been deactivated or deleted. Please contact your system administrator.';
                    }
                }
                else
                {
                    return 'Username does not exist.';
                }
            }
            else
            {
                return 'No students found in the system. Please contact your system administrator.';
            }
        }
        catch(Exception e)
        {
            return 'Error while signing in – '+e.getMessage()+' – '+e.getLineNumber();
        }
    }
    
    // forget password code
    
    @RemoteAction
    public static String receivePassword(String username)
    {
        try
        {
            List<Contact> stuList = [SELECT Id,Username__c,Password__c,Email,LastName
                                     FROM Contact
                                     WHERE Username__c != null AND Username__c != ''
                                     LIMIT 50000];
            
            Map<String,Contact> stuMap = new Map<String,Contact>();
            
            if(stulist != null && stulist.size() > 0)
            {
                For(Contact stu: stulist)
                {
                    If(String.isNotBlank(stu.Username__c))
                    {
                        stuMap.put(stu.Username__c,stu);
                    }
                }
                if(stuMap.containsKey(username))
                {
                    Contact stu = stuMap.get(username);
                    if(stu != null && String.isNotBlank(stu.Password__c) && String.isNotBlank(stu.Email))
                    {
                        string[] toAddresses = new string[]{stu.Email};
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(toAddresses);
                        mail.setSubject('Password Recovery');
                        mail.setHTMLBody('Hi '+stu.LastName+',<br/><br/><b>Username</b> = '+stu.Username__c+'<br/><b>Password</b> = '+stu.Password__c+'<br/><br/>Thanks<br/>ALU Student Portal');
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Sent Successfully.');
                        ApexPages.addMessage(myMsg);
                        return 'Success';
                    }
                    else
                    {
                        return 'Your account has been deactivated or deleted. Please contact your system administrator.';
                    }
                }
                else
                {
                    return 'Username does not exist.';
                }
            }
            else
            {
                return 'No students found in the system. Please contact your system administrator.';
            }
        }
        catch(Exception e)
        {
            return 'Error while signing in – '+e.getMessage()+' – '+e.getLineNumber();
        }
    }
    
    // code to get access token  this method is called when user click on logged in with gmail button
    
    public pageReference getAccessToken()
    {
        String googleURL = 'https://accounts.google.com/o/oauth2/auth?scope='+EncodingUtil.urlEncode('https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/plus.profile.emails.read','UTF-8')+'&state='+EncodingUtil.urlEncode('/profile','UTF-8')+'&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&response_type=code&client_id='+'466609379780-c4kj7jv89tq1ditbjnocn2vtpmbqjfrt.apps.googleusercontent.com'+'&approval_prompt='+'force';
        System.debug('googleURL '+googleURL);
        PageReference ref = new PageReference(googleURL);
        ref.setRedirect(true);
        return ref;   
    }
    
    
    
    
    // wrapper class to store response data
    
    public class googleEmailWrapper
    {
        public string type;
        public string value;
    }
}