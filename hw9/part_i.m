digitDatasetPath = fullfile('C:\Users\shish\Desktop\cs1674\Homeworks\hw9');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
figure
numImages = 1200;
perm = randperm(numImages,20);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
    drawnow;
end
numTrainingFiles = 100;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');
layers = [ ...
    imageInputLayer([227 227 3])
    convolution2dLayer(11,50, 'Stride',4)
    reluLayer
    maxPooling2dLayer(3,'Stride',1)
    convolution2dLayer(5,60)
    reluLayer
    maxPooling2dLayer(3,'Stride',2)
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm', ...
    'MaxEpochs',1,...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress');


net = trainNetwork(imdsTrain, layers, options);

YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;
accuracy = sum(YPred == YTest)/numel(YTest)