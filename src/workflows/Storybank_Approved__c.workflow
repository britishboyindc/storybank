<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
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
        <field>RecordTypeId</field>
        <lookupValue>Video_Submission</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set RecordType = Video</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
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
            <field>Storybank_Approved__c.Video_URL__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
