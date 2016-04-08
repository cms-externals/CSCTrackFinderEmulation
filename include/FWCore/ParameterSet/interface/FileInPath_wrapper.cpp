#include "FWCore/ParameterSet/interface/FileInPath_wrapper.h"
#include <cstdlib>

std::string FileInPath_wrapper(const char *r)
{
  std::string fullPath(getenv("CSC_TRACK_FINDER_DATA_DIR"));
  return fullPath+r;
}
