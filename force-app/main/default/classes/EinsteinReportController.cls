/*
* --------------------------------------------------------------------------------------------------
* To return ReportId for Redirecting in Einstein Configure Action
* --------------------------------------------------------------------------------------------------
* @author        Shashank Singla
* @modifiedBy     Shashank Singla
* @version        1.0
* @created        2020-10-06
* @used by 		 EinsteinReportRedirect
* @Description  Class Used to provide ReportId when Reportname along with Foldername is passed to it
*/
public class EinsteinReportController {
    
    @auraEnabled
    public static reportResponse fetchReportId(string developerName,string folderDeveloperName){
        reportResponse response = new reportResponse();
        try{
            list<Report> reports = new List<report>();
            list<folder> folders = new List<folder>();
            string folderQuery = 'select name from folder where developername=:folderDeveloperName';
            folders = database.query(folderQuery);
            set<String> foldernames = new set<String>();
            for(folder fl : folders ){
                foldernames.add((String)fl.get('Name'));
            }
            developerName = '%'+developerName+'%';
            string query = 'select id from report where developername LIKE :developerName and foldername=:foldernames'; 
            reports = database.query(query);
            response.reportId = reports[0].Id;
            response.status = 'success';
        }catch(Exception ex){
            system.debug('ex'+ex.getMessage()+'--Stack--'+ex.getStackTraceString());
            response.status = 'Either Report or Folder Not Found';
        }
        return response; 
    }
    public class reportResponse{
        @auraEnabled
        public string reportId;
        @auraEnabled        
        public string status;
    }
}