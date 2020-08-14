/*
* @author        Anirudh Raturi
* @version       PE Einstein Configuration Code v1.0
* @created       2020-31-06
* @Description   This test Class is used to test the class EinsteinReportController 
*/

@isTest (SeeAllData=true)
public class Test_EinsteinReportController{
    public static testMethod void TestEinsteinReport() {
        list<Report> lstofReport =[SELECT Id, DeveloperName, FolderName FROM Report where FolderName!=null and Foldername!='Public Reports' limit 1];
        if(lstofReport.size()>0) {
            list<Folder> listofFolder =[SELECT Id, DeveloperName FROM Folder where name=:lstofReport[0].FolderName];
            EinsteinReportController.reportResponse result=EinsteinReportController.fetchReportId(lstofReport[0].DeveloperName,listofFolder[0].DeveloperName); 
            System.assertEquals('success',result.status);

        }               
    }	
}