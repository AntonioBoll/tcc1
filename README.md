# Topic Modeling using BERTopic

This was done as my end of graduation project at UFRGS.

It consists of a topic modeling using BERTopic to cluster non labeled information from electronic invoices obtained by SEFAZ-RS, the state treasury office at Rio Grande do Sul (BR).

This was done using two types of databases that cannot be shared, the first being one refined by a markov chain that grouped products that relate to milk and meat, while the second was not done any refinement.

It was evaluated and was given the maximum grade possible.

The codes in this github repository are:

* bert_refined: This is the main code for the Topic Modeling using the refined dataset;
* refined_images: This is a folder that contains the three generated images from the refined dataset. The first is a distance map for the topics. The second consists of word scores for each topic. The third is a similarity matrix for the topics generated;
* bert_non_refined: This is the main code for the Topic Modeling using the non refined dataset;
* refined_images: This is a folder that contains the three generated images from the non refined dataset. The first is a distance map for the topics. The second consists of word scores for each topic. The third is a similarity matrix for the topics generated;
* preprocessing_database: This is the code used to preprocess the non refined dataset;
* groups_modeling: This is the code used to generate the images from each topic.

The full text is available only in Portuguese and is acessible using this link: .
