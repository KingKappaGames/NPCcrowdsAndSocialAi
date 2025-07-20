if(live_call()) { return live_result }

var _right = view_wport[0];

draw_set_alpha(.3);

draw_rectangle_color(_right, 420, _right - 280, 120, c_grey, c_grey, c_dkgray, c_dkgray, false);

draw_set_alpha(1);

draw_text(_right - 260, 140, "Current node: " + string(ChatterboxGetCurrent(chatterbox)));
draw_text(_right - 260, 180, "Total lines: " + string(dialogueValueCollection.totalDialogueLinesGiven))
draw_text(_right - 260, 220, "Times met: " + string(dialogueValueCollection.timesMet))
draw_text(_right - 260, 260, "Have met once: " + string(dialogueValueCollection.firstMet))
draw_text(_right - 260, 300, "Secret told: " + string(dialogueValueCollection.secretTold))
draw_text(_right - 260, 340, "Options chosen: " + string(optionChosenArrayDebug))
draw_text(_right - 260, 380, "Options viable: " + string(optionCriteriaArrayDebug))