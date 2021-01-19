public class ParkLocator {

    public static List<String> country(String name){
        
        ParkService.ParksImplPort pb=new ParkService.ParksImplPort();
        
        return pb.byCountry(name);
    }
}