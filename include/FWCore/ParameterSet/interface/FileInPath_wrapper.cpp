#include "FWCore/ParameterSet/interface/FileInPath_wrapper.h"
#include "FWCore/ParameterSet/interface/FileInPath.h"

std::string FileInPath_wrapper(const char *r)
{
  edm::FileInPath *fpath = new edm::FileInPath(r);
  std::string fullpath = fpath->fullPath();
  delete fpath;
  return fullpath;
}

