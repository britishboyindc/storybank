global with sharing class StoryCollectionController {
/* 
Class to control public facing web page for Storybank
The class is declared as Global so that customers can clone the included page and use their own
to capture stories
*/

private Storybank_Submitted__c story;


global StoryCollectionController () {
 
    story = new Storybank_Submitted__c(); 
 
}

global Storybank_Submitted__c getstory() {
    return story;
}

 global PageReference submit() {


    try {
        insert story;
        return page.StorybankSubmissionConfirmation;
    }
    Catch (Exception Ex) {
        return null;
    } 

} //end submit 

}