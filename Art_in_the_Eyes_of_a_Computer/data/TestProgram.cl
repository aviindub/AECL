__kernel void updateSpot(__global float *x, 
                        __global float *y, 
                        __global float *directionX,
                        __global float *directionY,
                        __global float *resultX, 
                        __global float *resultY,
                        const float speedX,
                        const float speedY) {
    
    int gid = get_global_id(0);
    resultX[gid] = x[gid] + (speedX * directionX[gid]);
    resultY[gid] = y[gid] + (speedY * directionY[gid]);
}


/*
//--------------------------------------------------------------
__kernel void inverse(__global float *a, __global float *result) 
{
	int gid = get_global_id(0);
	result[gid] = 1.0f/a[gid];
}

//--------------------------------------------------------------
__kernel void square(__global float *a, __global float *result) 
{
	int gid = get_global_id(0);
	result[gid] = a[gid] * a[gid];
}

//--------------------------------------------------------------
__kernel void multiplyScaler(__global float *a, const float b, __global float *result) 
{
	int gid = get_global_id(0);
	result[gid] = a[gid] * b;
	//result[gid] = a[gid] * (*b);
}
*/
