package 
{

import mx.resources.ResourceBundle;

[ExcludeClass]

public class en_US$messages_properties extends ResourceBundle
{

    public function en_US$messages_properties()
    {
		 super("en_US", "messages");
    }

    override protected function getContent():Object
    {
        var content:Object =
        {
            "onhold": "<font color=\"#FF0000\"><b>A hold has been placed on your GEDCOM.</b></font> Would you please review the messages on your talk page shown below?  Once the questions have been resolved the hold will be removed.",
            "returntowerelate": "Finish your review later.",
            "gedcomhold": "The GEDCOM has been placed on hold. Please go to your talk page (select Talk Page from the MyRelate menu) for more information.",
            "notImportable": "Your GEDCOM cannot be imported to WeRelate in its current form, either because it has too many warnings or it contains duplicates.  Click on the Warnings tab, print the warnings, correct or remove the incorrect information in your desktop genealogy program, remove this GEDCOM, and upload a revised GEDCOM.",
            "notsignedin": "Please sign in by clicking on the 'Sign in' link near the upper-right corner of the page, then re-load this program by clicking on the review link again.",
            "statusdelete": "Your GEDCOM has been removed.",
            "statusanalyzing": "Your GEDCOM is currently being analyzed.  Please check back later.",
            "statuswaiting": "Your GEDCOM is waiting to be analyzed.  Please check back later.",
            "unexpectederror": "Something went wrong. It's our fault. Please try again later.",
            "notReadyWarnings": "Click on each of the warnings in the Warnings tab to review the warning.",
            "phase3": "Your GEDCOM is ready for import and will be imported shortly.",
            "notauthorized": "You are not authorized to review this GEDCOM; if you have questions, please contact dallan@werelate.org",
            "phase2": "<b>Congratulations!</b> Your GEDCOM is ready to import.  Click on the button below.",
            "notReady": "<b>Before your GEDCOM is ready to import, you need to:</b>",
            "tip_find_add_place": "To find or add a matching place in the place index:<li>First, make sure that the name of the place is correct in the form below and click <b>Find/Add</b>,</li><li>Then, click <b>Select</b> to select one the places shown, or <b>Add</b> to create a new place page.</li>",
            "tip_merge": "Congratulations! Now that you have matched your family to an existing family, you can now update the existing family with information from your GEDCOM. <br><br>Updating the existing family is optional. It is not necessary or desirable to update unless you have more accurate information or reliable sources to add.<br><br>If your GEDCOM has too many warnings you will not be able to update the existing families at this time.<br><br>To update, check the boxes to the left of the information you want to add, and click <b>Update</b>.",
            "tip_match": "Link the people in your GEDCOM to existing people at WeRelate.<li>First, check the box above the matching family.  If multiple families match, just check one. You can merge the others after you upload your GEDCOM.</li><li>Second, check the boxes above the matching husband and wife, and set the child number under each child in the matching family to the number of the matching child in the GEDCOM family.</li><li>Third, click <b>Match</b> to match the family.</li>Click the <b>Help</b> button in the upper right corner for help.",
            "probablyNotImportable": "Your GEDCOM has a high percentage of warnings and will likely be rejected.  We recommend that you click on the Warnings tab, print the warnings, correct or remove the incorrect information in your desktop genealogy program, remove this GEDCOM, and upload a revised GEDCOM.",
            "adminReviewAdmin": "Dear Admin,<ul><li>please click on <b>Ready to import</b> if the GEDCOM is ok to import,</li><li>leave a message for <b>{0}</b> if there are questions or problems, or</li><li>click on <b>Return to user review</b> to allow the uploader to re-review the GEDCOM.</li></ul>",
            "warningsAboveUpperThreshold": "This file has too many warnings to import.  Click on the Warnings tab, print the warnings, correct or remove the incorrect information in your desktop genealogy program, remove this GEDCOM, and upload a revised GEDCOM.",
            "notReadyFamilies": "Click on each of the families in the Family Matches tab, decide whether the existing family matches your GEDCOM family, and click on 'Match' or 'Not a Match' in the bottom pane.",
            "statuszero": "Something went wrong. It's our fault. Please try again later.",
            "statushold": "The GEDCOM has been placed on hold.",
            "nextsteps": "Click on the tabs in the order shown above.  Read the help in the bottom frame or click the <i>Help</i> button. <b>Tip</b>: Drag the dividing bar below up or down to resize the bottom pane.",
            "statusphase3": "Thank you! Wiki pages for your GEDCOM will be created shortly. You will receive a message on your talk page as soon as they are ready. ",
            "statusphase2": "The GEDCOM has been returned to user review.",
            "adminReview": "An administrator will review your GEDCOM shortly and finalize the import or contact you with any questions.",
            "gedcomnotfound": "Error reading the GEDCOM; please try again in a few minutes; if you have questions, please contact dallan@werelate.org",
            "internalDuplicates": "Files with internal duplicates cannot be imported.  Review the duplicates on the Warnings tab, remove the duplicates from your desktop genealogy program, remove this GEDCOM, and upload a revised GEDCOM.",
            "statusother": "Something went wrong. It's our fault. Please try again later.",
            "tip_find_add_source": "To find or add a matching source in the source index:<li>First, select the type of source, fill in any missing information, and click <b>Find/Add</b>,</li><li>Then, click <b>Select</b> to select one the sources shown, or <b>Add</b> to create a new source page.</li>",
            "removegedcom": "In case you change your mind about uploading this GEDCOM, you can remove it.",
            "warningsAboveLowerThreshold": "This file has a high percentage of warnings and will likely be rejected.  We recommend that you click on the Warnings tab, print the warnings, correct or remove the incorrect information in your desktop genealogy program, remove this GEDCOM, and upload a revised GEDCOM."
        };
        return content;
    }
}



}
