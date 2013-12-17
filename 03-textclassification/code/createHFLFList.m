function HFLFList = createHFLFList(Global)


%hf_terms = (Global.Ranked_Vocabulary_Frequencies/max(Global.Ranked_Vocabulary_Frequencies))>0.03;
lf_terms = Global.Ranked_Vocabulary_Frequencies<=1;
%HFLFList = hf_terms+lf_terms;
HFLFList = lf_terms;
disp(['going to delete: ', num2str(sum(HFLFList)), ' words!'])


