#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \
green:((c>>16)&0xFF)/255.0 \
blue:((c>>8)&0xFF)/255.0 \
alpha:((c)&0xFF)/255.0];


#ifdef DEBUG
    #define LOG(...) NSLog(__VA_ARGS__)
    #define LOG_CURRENT_METHOD NSLog(NSStringFromSelector(_cmd))
#else
    #define LOG(...) ;
    #define LOG_CURRENT_METHOD ;
#endif

#define objMaxNumVerts 75000
#define objMaxNumMats  64

// flash is upper left. cocos2d is lower left.
// My vector gfx tool uses upper left coordinates
static inline double adjustForUpperLeftAnchor(float f)
{
    return 320 - f; // anchor difference
}

// !! quick hack
static inline double adjustForStatusBar(float f) 
{
    return 12 + f; // anchor difference
}

// rand() is not fast, or random, or the same across systems. So here is RANROT-B PRNG.
static int m_lo = 0, m_hi = ~0;
static inline void sdrand(int seed) 
{ 
    m_lo = seed; 
    m_hi = ~seed; 
}
static inline unsigned int uirand() 
{ 
    m_hi = (m_hi<<16) + (m_hi>>16); 
    m_hi += m_lo; 
    m_lo += m_hi;
    
    return m_hi & INT_MAX; 
}
static inline int irand() 
{ 
    m_hi = (m_hi<<16) + (m_hi>>16); 
    m_hi += m_lo; 
    m_lo += m_hi; 
    
    return m_hi; 
}

static inline float ufrand(float x) 
{ 
    return ((x * uirand()) / (float)INT_MAX); 
}

static inline float frand(float x) 
{ 
    return ((x *  irand()) / (float)INT_MAX); 
}

/*
 * From Jeff Lamarche
 * http://iphonedevelopment.blogspot.com/2008/12/start-of-wavefront-obj-file-loader.html
 */

// How many times a second to refresh the screen
#define kRenderingFrequency 60.0

// For setting up perspective, define near, far, and angle of view
#define kZNear			0.01
#define kZFar			1000.0
#define kFieldOfView	45.0

#define kGroupIndexVertex 0


