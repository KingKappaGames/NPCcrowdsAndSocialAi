showDebug = 0;

name = -1;

residence = -1; // specific city or village, not house, not region (could be none / travellor maybe?)
homeland = -1;
gender = -1;
age = -1;
relationshipLevelPartner = -1;
relationshipPartner = -1;
objectAllegiance = -1;

occupation = -1;
religion = -1;
wealth = -1;
status = -1;
alignment = -1;
criminality = -1;
magicStrength = -1;
magicField = -1;
powerLevel = -1;

extraversion = -1;
selfWorth = -1;
personality = -1;
trust = -1;
energyPersonality = -1; // this would be vitality/how spry they were, age is a big impact but also magic and history
joy = -1;
curiosity = -1;
combativeness = -1;
knowledgeGeneral = -1;

speedValue = -1;
weightValue = -1;
keenness = -1;

script_npcGeneratePersonality();

emotionOpinion = .5;
emotionMood = .5;
emotionTrust = .5;
emotionAnger = .5;
emotionFear = .5;
emotionEnergy = .5; // i dont think player needs these but for now I'll let them sit here

npcRelationshipCollection = [];

createNpcRelationship = function(target) {
	var _relationshipInfo = {
		npcSelf: id, // the "self" since I'm not sure this wouldn't be hard to get otherwise... at some point
		npc: target, // the npc of which you hold this opinion
		opinion: .5,
		mood: .5,
		trust: .5,
		anger: 0,
		fear: 0,
		energy: .5,
		debt: 0,
	}
	
	array_push(npcRelationshipCollection, _relationshipInfo); // remember to add the data struct to the array moron
	
	return _relationshipInfo;
}