#ifndef CSCTrackFinderEmulation_FileInPath_h
#define CSCTrackFinderEmulation_FileInPath_h
namespace edm
{
  class FileInPath
  {
  public:
    FileInPath(const char* r);
    std::string fullPath() const;
  };
}
#endif

