function ret = CSE467_Assignment_2(im)
temp = 0;
intensity_sum = 0;
intraclass_1_intensity_sum=0;
intraclass_2_intensity_sum=0;
class_1_probability = 0;
class_2_probability = 0;
class_1_mean=0;
class_2_mean=0;
class_1_variance = 0;
class_2_variance = 0;
within_class_variance = 0;
minimum_within_class_variance = 1000000000000000;

gray = graythresh (im);

[y,x] = imhist(im);

for i = 1:256
    intensity_sum = intensity_sum+y(i);
end

for i = 1:256
    for j = 1:i
        temp = temp+ y(j);
    end
    class_1_probability = temp / intensity_sum;
    temp=0;
    
    for j = (i+1):256
        temp = temp+y(j);
    end
    class_2_probability = temp/intensity_sum;
    temp=0;
    
    for j = 1:i
        temp  = temp + ( j * y(j));
        intraclass_1_intensity_sum = intraclass_1_intensity_sum + y(j);
    end
    class_1_mean = temp/intraclass_1_intensity_sum;
    temp =0;
    
    for j = (i+1):256
        temp  = temp + ( j * y(j));
        intraclass_2_intensity_sum = intraclass_2_intensity_sum + y(j);
    end
    if ( intraclass_2_intensity_sum ~=0 )        
        class_2_mean = temp/intraclass_2_intensity_sum;
    end
    temp =0;
    
    for j = 1:i
        temp = temp + ((power((j-class_1_mean),2))*y(j));
    end
    class_1_variance = temp/intraclass_1_intensity_sum;
    intraclass_1_intensity_sum = 0;
    temp=0;
    
    for j = (i+1):256
        temp = temp + ((power((j-class_2_mean),2))*y(j));
    end
    if ( intraclass_2_intensity_sum ~=0 )
        class_2_variance = temp/intraclass_2_intensity_sum;
        intraclass_2_intensity_sum = 0;
    end
    temp=0;
    
    within_class_variance = (class_1_probability * class_1_variance) + (class_2_probability * class_2_variance);
    
    if ( minimum_within_class_variance >= within_class_variance )
        minimum_within_class_variance = within_class_variance;
        threshold_point = i;
    end
end
ret=(threshold_point-1)/255;