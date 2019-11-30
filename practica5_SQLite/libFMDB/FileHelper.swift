import Foundation

class FileHelper {

    let objetoFileManager = FileManager.default


//Regresa el path de la carpeta de documentos de la app
func pathCarpetaDocumentos() -> String {
    
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    return documentsFolderPath
}

//Regresa el path completo de un archivo que este dentro de la carpeta de documentos
func pathArchivoEnCarpetaDocumentos(_ nombreArchivo: String) -> String{
    return (pathCarpetaDocumentos() as NSString).appendingPathComponent(nombreArchivo)
}

//Revisa si existe o no un archivo en el directorio de documentos

func existeArchivoEnDocumentos(_ nombreArchivo: String) -> Bool{
    var existe:Bool?
    
    if (objetoFileManager.fileExists(atPath: pathArchivoEnCarpetaDocumentos(nombreArchivo)))
    {
        print("El archivo \(nombreArchivo) existe en el path de documentos.");
        existe = true
    }
    else
    {
        print("El archivo \(nombreArchivo) No existe en el path de documentos.");
        existe = false
    }
    
    return existe!
}

//Data Base

func pathBaseDatosEnBundle(_ nombreBaseDatos: String) -> String{
    let path = Bundle.main.path(forResource: nombreBaseDatos, ofType:"sqlite")
    return path!
}


func dbExisteEnBundle(_ nombreBaseDatos: String) -> Bool{
    var valor:Bool?
    
    
    
    if ((Bundle.main.path(forResource: nombreBaseDatos, ofType:"sqlite")) != nil)
    {
        print("La base de datos si existe en el bundle");
        valor = true
    }
    else
    {
        print("La base de datos no existe en el bundle");
        valor = false
    }
    
    return valor!
}



}

