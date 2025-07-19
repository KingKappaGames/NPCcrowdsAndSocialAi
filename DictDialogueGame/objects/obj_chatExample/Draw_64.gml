if(live_call()) { return live_result }
draw_text(view_wport[0] - 240, 140, "Total lines: " + string(dialogueValueCollection.totalDialogueLinesGiven))
draw_text(view_wport[0] - 240, 180, "Times met: " + string(dialogueValueCollection.timesMet))
draw_text(view_wport[0] - 240, 220, "Have met once: " + string(dialogueValueCollection.firstMet))
draw_text(view_wport[0] - 240, 260, "Secret told: " + string(dialogueValueCollection.secretTold))
draw_text(view_wport[0] - 240, 300, "Options chosen: " + string(optionChosenArrayDebug))