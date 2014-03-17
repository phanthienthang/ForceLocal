public with sharing class RouteController {

    public String routeLink {get; set;}

    public RouteController() {        
        String baseUrl = ApexPages.currentPage().getHeaders().get('Referer'); 
        //System.debug(ApexPages.currentPage().getHeaders());       
        routeLink = baseUrl.subString(baseUrl.indexOf('=')+1, baseUrl.length());
        //System.debug(routeLink);
    }


}