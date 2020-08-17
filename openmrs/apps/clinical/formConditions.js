Bahmni.ConceptSet.FormConditions.rules = {
    'Diastolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Systolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Source of referral' : function (formName, formFieldValues) {
        var sourceofreferral = formFieldValues['Source of referral'];
        if (sourceofreferral === "Other source of referral (Specify)") {
            return {
                show: ["Specify other source of referral"]
            }
        } else {
            return {
                hide: ["Specify other source of referral"]
            }
        }
    },
    'Presenting complaints' : function (formName, formFieldValues) {
        var presentingcomplaints = formFieldValues['Presenting complaints'];
        if (presentingcomplaints === "Feeling Low") {
            return {
                show: ["Other presenting complaints"]
            }
        } else {
            return {
                hide: ["Other presenting complaints"]
            }
        }
    },
    'Trigger factors/history of presenting complaints' : function (formName, formFieldValues) {
        var historypresentingcomplaints = formFieldValues['Trigger factors/history of presenting complaints'];
        if (historypresentingcomplaints === "Other trigger factors (Please specify)") {
            return {
                enable: ["Specify other trigger factors"] 
            }
        } else {
            return {
                disable: ["Specify other trigger factors"]
            }
        }
    }

};