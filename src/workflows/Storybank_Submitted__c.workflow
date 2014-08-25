<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Post_to_Chatter</fullName>
        <field>Post_to_Chatter__c</field>
        <literalValue>1</literalValue>
        <name>Post to Chatter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Embed_URL</fullName>
        <description>Set via Workflow so can be overridden</description>
        <field>Embed_URL__c</field>
        <formula>IF(CONTAINS(Video_URL__c, &quot;youtu.be&quot;) , &quot;https://www.youtube.com/embed/&quot; + RIGHT(Video_URL__c, LEN(Video_URL__c) - FIND(&quot;/&quot;,Video_URL__c,8)), 

IF(CONTAINS(Video_URL__c, &quot;vimeo&quot;) , &quot;https://player.vimeo.com/video/&quot; + RIGHT(Video_URL__c, 8), 

Video_URL__c
))</formula>
        <name>Set Embed URL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_RecordType_Video</fullName>
        <description>When there is a URL, set RecordType = Video so that Embed Video Functionality is Displayed on page</description>
        <field>RecordTypeId</field>
        <lookupValue>Video_Submission</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set RecordType = Video</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Submission_Type_to_External</fullName>
        <description>Set the Submission type field to External based on a workflow rule</description>
        <field>Submission_Type__c</field>
        <literalValue>External</literalValue>
        <name>Set Submission Type to External</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Video_Flag_TRUE</fullName>
        <field>Video__c</field>
        <literalValue>1</literalValue>
        <name>Set Video Flag = TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_RT_to_Text_Converted</fullName>
        <description>Change the current Recordtype over to Text converted</description>
        <field>RecordTypeId</field>
        <lookupValue>Text_Converted</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update RT to Text Converted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_RT_to_Video_Converted</fullName>
        <description>Change the current Recordtype over to Video converted</description>
        <field>RecordTypeId</field>
        <lookupValue>Video_Converted</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update RT to Video Converted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Set Default Submission type</fullName>
        <actions>
            <name>Set_Submission_Type_to_External</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Storybank_Submitted__c.Submission_URL__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow rule sets the submission type based on whether the Storybank - Submitted record was created externally via Sites or internally.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Embed URL</fullName>
        <actions>
            <name>Set_Embed_URL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISCHANGED(Video_URL__c),ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set RecordType for Video</fullName>
        <actions>
            <name>Set_RecordType_Video</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Video_Flag_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Storybank_Submitted__c.Video_URL__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Switch to Converted RT - Text</fullName>
        <actions>
            <name>Update_RT_to_Text_Converted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Storybank_Submitted__c.Status__c</field>
            <operation>equals</operation>
            <value>Converted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Storybank_Submitted__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Text Submission</value>
        </criteriaItems>
        <description>When the status of a submitted story is changed to converted then switch the RT/PL to show change and remove edit and additional conversions</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Switch to Converted RT - Video</fullName>
        <actions>
            <name>Update_RT_to_Video_Converted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Storybank_Submitted__c.Status__c</field>
            <operation>equals</operation>
            <value>Converted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Storybank_Submitted__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Video Submission</value>
        </criteriaItems>
        <description>When the status of a submitted story is changed to converted then switch the RT/PL to show change and remove edit and additional conversions</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Post to Chatter</fullName>
        <actions>
            <name>Post_to_Chatter</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Storybank_Submitted__c.Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
